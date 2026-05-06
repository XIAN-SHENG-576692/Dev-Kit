import clang.cindex
import sys

def main():
    file_path = sys.argv[1]

    index = clang.cindex.Index.create()
    tu = index.parse(file_path)

    function_list=[]

    for cursor in tu.cursor.get_children():
        if (
            cursor.is_definition()
            and cursor.location.file
            and cursor.location.file.name == file_path
            and cursor.kind in [
                clang.cindex.CursorKind.FUNCTION_DECL,
                clang.cindex.CursorKind.CXX_METHOD,
            ]
        ):
            function_list.append({
                "cursor":cursor,
                "args_cursor":[arg for arg in cursor.get_arguments()]
            })

    output=""
    for func in function_list:
        # parameters
        cursor=func["cursor"]
        args_declare=[f"{arg.type.spelling} {arg.spelling}" for arg in func["args_cursor"]]
        args_declare_in_struct="".join([f"{arg};" for arg in args_declare])
        args_pass=",".join([f"args->{arg.spelling}" for arg in func["args_cursor"]])
        args_struct_name=f"__{cursor.spelling}_args__"
        func_call_name=f"__{cursor.spelling}_call__"
        func_call_macro_name=f"{cursor.spelling}_call"
        # struct
        output+="typedef struct {"
        output+=f"{args_declare_in_struct}"
        output+="}"
        output+=f" {args_struct_name};"
        # call function
        output+=f"inline {cursor.result_type.spelling} {func_call_name}(const {args_struct_name} *const args)"
        output+="{"
        output+=f"return {cursor.spelling}({args_pass});"
        output+="};"
        # macro
        output+=f"\n#define {cursor.spelling}_call(...) "
        output+=f"{func_call_name}(&(const {args_struct_name}) ""{__VA_ARGS__})\n"
    
    print(output)

if __name__ == '__main__':
    main()
