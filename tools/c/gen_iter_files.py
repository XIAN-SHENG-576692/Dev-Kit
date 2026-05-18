import argparse
import json
import os
import itertools
import re

def generate_files(json_path, source_files):
    # 1. 讀取並解析 JSON 檔案
    try:
        with open(json_path, 'r', encoding='utf-8') as f:
            type_mapping = json.load(f)
    except Exception as e:
        print(f"Error reading JSON file: {e}")
        return

    # 提取 JSON 中的 Key (如 TESTA, TESTB) 與對應的 Value 列表
    keys = list(type_mapping.keys())
    value_groups = [type_mapping[k] for k in keys]

    # 2. 處理每一個原始碼檔案
    for src_path in source_files:
        if not os.path.exists(src_path):
            print(f"Warning: File {src_path} not found. Skipping.")
            continue

        with open(src_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # 取得檔名與副檔名 (例如 test, .h)
        base_name, ext = os.path.splitext(os.path.basename(src_path))

        # 3. 產生所有型別的笛卡兒積 (Cartesian Product)
        # 例如: (int8_t, float), (int8_t, double) ...
        for combination in itertools.product(*value_groups):
            new_content = content
            name_suffix = ""

            # 進行字串替換並建立檔名後綴
            for key, val in zip(keys, combination):
                new_content = new_content.replace(key, val)
                name_suffix += f"_{val}"

            # 4. 生成新檔案
            output_filename = f"{base_name}{name_suffix}{ext}"
            try:
                with open(output_filename, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Generated: {output_filename}")
            except Exception as e:
                print(f"Error writing {output_filename}: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate source files based on type combinations from a JSON file.")
    parser.add_argument("--json", required=True, help="Path to the JSON mapping file.")
    parser.add_argument("sources", nargs="+", help="One or more source files to process.")

    args = parser.parse_args()
    generate_files(args.json, args.sources)