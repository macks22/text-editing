"""
This module contains a script for parsing a markdown document into a
table of contents. It uses the header hashes (##, ###, ...) to identify
header lines, then parses those lines into a numbered, properly indented
toc.

"""
import os
import sys


def parse_toc(filepath):
    """Extract all markdown headers from the given file and parse them into a
    table of contents.

    :param str filepath: The path of the file to parse.

    """
    with open(filepath) as f:
        headers = [line for line in f if line.startswith('#')]

    header_fields = []
    tag_lengths = set()
    for header in headers:
        tokens = header.split()
        tag_len = len(tokens[0])
        tag_lengths.add(tag_len)
        header_fields.append([tag_len, ' '.join(tokens[1:])])

    # adjust header levels based on highest level present
    highest_level = min(tag_lengths)
    header_fields = [[header[0] - highest_level, header[1]] for header in
            header_fields]

    header_fields.reverse()  # set up list for iterative pops (stack)
    toc = _toc_from_headers(header_fields)

    return '\n'.join(toc)


def _toc_from_headers(header_fields, level=0):
    toc = []
    num = 1
    for item in header_fields:
        tag, text = header_fields[-1]
        if tag == level:
            indent = '    ' * tag
            number_string = '{}.'.format(num)
            extra_space = ' ' * (4 - len(number_string))
            toc.append('{}{}{}{}'.format(
                indent, number_string, extra_space, text))
            num += 1
            header_fields.pop()
        elif tag > level:  # nested subsection
            toc += _toc_from_headers(header_fields, level=tag)
        else:  # done with subsection
            return toc

    return toc


def write_toc(toc, filepath):
    lines = []
    with open(filepath, 'Ur') as fp:
        last_pos = fp.tell()
        line = fp.readline()

        while not line.startswith('#'):
            lines.append(line)
            last_pos = fp.tell()
            line = fp.readline()

        tag = line.split()[0]

        # reached first markdown header
        fp.seek(last_pos)
        rest = fp.read()

    lines.append('\n{} Table of Contents\n\n{}\n\n'.format(tag, toc))
    os.rename(filepath, filepath + '~')

    with open(filepath, 'w') as fp:
        fp.write(''.join(lines) + rest)


def main():
    markdown_file = sys.argv[1]
    toc = parse_toc(markdown_file)
    write_toc(toc, markdown_file)


if __name__ == "__main__":
    sys.exit(main())
