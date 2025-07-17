### FILE UTILITIES ###

# Create backup of file
# Usage: backup file.txt -> creates file.txt.bak
function backup --argument filename
    if test -z "$filename"
        echo "Usage: backup <filename>"
        return 1
    end
    if not test -f "$filename"
        echo "Error: File '$filename' not found"
        return 1
    end
    cp $filename $filename.bak
    echo "Backup created: $filename.bak"
end

# Enhanced copy function for files and directories
# Usage: copy SOURCE DEST
function copy
    set count (count $argv)
    if test $count -ne 2
        echo "Usage: copy <source> <destination>"
        return 1
    end

    if test -d "$argv[1]"
        set from (echo $argv[1] | string trim --right --chars=/)
        set to $argv[2]
        command cp -r $from $to
        echo "Directory copied: $from -> $to"
    else
        command cp $argv
        echo "File copied: $argv[1] -> $argv[2]"
    end
end

### TEXT PROCESSING UTILITIES ###

# Extract specific column from whitespace-delimited input
# Usage: echo "1 2 3" | coln 2 -> outputs "2"
function coln --argument column_num
    if test -z "$column_num"
        echo "Usage: coln <column_number>"
        return 1
    end
    while read -l input
        echo $input | awk "{print \$$column_num}"
    end
end

# Extract specific row from input
# Usage: seq 10 | rown 5 -> outputs "5"
function rown --argument index
    if test -z "$index"
        echo "Usage: rown <row_number>"
        return 1
    end
    sed -n "$index p"
end

# Skip first n lines of input
# Usage: seq 10 | skip 3 -> outputs lines 4-10
function skip --argument n
    if test -z "$n"
        echo "Usage: skip <number_of_lines>"
        return 1
    end
    tail +(math 1 + $n)
end

# Take first n lines of input
# Usage: seq 10 | take 3 -> outputs lines 1-3
function take --argument number
    if test -z "$number"
        echo "Usage: take <number_of_lines>"
        return 1
    end
    head -$number
end
