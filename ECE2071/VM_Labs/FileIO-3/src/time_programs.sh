

music_path="../outputs/music_analysis ../data/music_info.txt > /dev/null"
code_path="../outputs/code_cracking ../data/encrypted.txt > /dev/null"


# Time for Music Analysis
startTime=$(date +%s.%N)
for i in {1..100}
do
    program_output=$($music_path)
done
endTime=$(date +%s.%N)
timeDifference=$(echo "$endTime-$startTime" | bc)
echo "Music Analysis: $timeDifference seconds"

# Time for code cracking
startTime=$(date +%s.%N)
for i in {1..100}
do
    test=$($code_path)
done
endTime=$(date +%s.%N)
timeDifference=$(echo "$endTime-$startTime" | bc)
echo "Code Cracking: $timeDifference seconds"
