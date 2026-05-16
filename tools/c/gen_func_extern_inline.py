import clang.cindex
from clang.cindex import LinkageKind
import sys

def is_function_inline(cursor):
    for token in cursor.get_tokens():
        if token.spelling == 'inline':
            return True
    return False

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
            and cursor.linkage == LinkageKind.EXTERNAL
            and is_function_inline(cursor)
        ):
            function_list.append({
                "cursor":cursor,
                "args_cursor":[arg for arg in cursor.get_arguments()]
            })

    output=""
    for func in function_list:
        # parameters
        cursor=func["cursor"]
        args_declare=[" ".join([token.spelling for token in arg.get_tokens()]) for arg in func["args_cursor"]]
        args_declare_in_func=",".join(args_declare)
        # function
        output+=f"extern inline {cursor.result_type.spelling} {cursor.spelling}({args_declare_in_func});"
    
    print(output)

if __name__ == '__main__':
    main()
