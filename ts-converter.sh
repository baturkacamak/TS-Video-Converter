#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Welcome message
echo -e "${GREEN}Welcome to the TS File Downloader and Converter! 🚀${NC}"
echo -e "${YELLOW}This script downloads TS files from a specified URL pattern, combines them, and converts the combined file into an MP4 format.${NC}\n"

# Function to print timestamped messages with color
print_msg() {
  echo -e "${YELLOW}[$(date +"%Y-%m-%d %H:%M:%S")]${NC} $1"
}

# Check for required tools and attempt to install them if they're missing
check_and_install_tools() {
  for tool in curl ffmpeg; do
    if ! command -v $tool &> /dev/null; then
      print_msg "${RED}Missing required tool: $tool. Attempting to install...${NC}"
      if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
          sudo apt-get update && sudo apt-get install -y $tool
        elif command -v yum &> /dev/null; then
          sudo yum install -y $tool
        else
          print_msg "${RED}Package manager not supported. Please install $tool manually.${NC}"
        fi
      elif [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
          brew install $tool
        else
          print_msg "${RED}Homebrew not found. Please install Homebrew and $tool manually.${NC}"
        fi
      else
        print_msg "${RED}OS not supported. Please install $tool manually.${NC}"
      fi
    fi
  done
}

# Base URL for downloading the files
base_url=$1
pattern=$2

# Check if base URL and pattern are provided
if [ "$#" -ne 2 ]; then
  print_msg "${RED}Error: Missing required arguments.${NC}"
  echo -e "${YELLOW}Usage: $0 <base_url> <file_pattern>${NC}"
  echo -e "${YELLOW}Example: $0 https://example.com/path/to/files/ 'seg-{i}-v1-a1.ts'${NC}"
  echo -e "${YELLOW}Use {i} where the sequence number should be inserted.${NC}"
  exit 1
fi

# Ensure necessary tools are available
check_and_install_tools

# Directory for temporary files
temp_dir="/tmp/ts_downloader"
mkdir -p "$temp_dir"
print_msg "${GREEN}Created temporary directory at ${temp_dir} for download. 📁${NC}"

# Output filename for the combined .ts file
combined_ts="${temp_dir}/combined.ts"

# Initialize segment index
i=1

# Loop to check each file's existence on the server and download
print_msg "${GREEN}Starting download process... 🌐${NC}"
while true; do
    segment_name=$(echo $pattern | sed "s/{i}/$i/g")
    full_url="${base_url}${segment_name}"
    local_filename="${temp_dir}/segment${i}_0_av.ts"

    status=$(curl -o /dev/null --silent --head --write-out '%{http_code}' "$full_url")

    if [ "$status" -eq 200 ]; then
        print_msg "${GREEN}Downloading $segment_name... 📥${NC}"
        curl -s -o "$local_filename" "$full_url"
    else
        print_msg "${RED}No more files to download. Last checked: $segment_name 🛑${NC}"
        break
    fi

    ((i++))
done

# Combine downloaded .ts files into a single .ts file
print_msg "${GREEN}Combining TS files into $combined_ts 🔨${NC}"
for ts_file in ${temp_dir}/*.ts; do
    cat "$ts_file" >> "$combined_ts"
done

# Clean up the individual .ts files
print_msg "${GREEN}Cleaning up individual .ts files... 🧹${NC}"
rm ${temp_dir}/segment*_0_av.ts

# Output path for the .mp4 file in the current directory of the script
base_name="output"
extension=".mp4"
counter=1
output_mp4="$(pwd)/${base_name}${extension}"

# Check if the file exists and find a unique name
while [ -f "$output_mp4" ]; do
    output_mp4="$(pwd)/${base_name}_${counter}${extension}"
    ((counter++))
done

print_msg "${GREEN}Converting combined TS file to MP4 format... 🔄${NC}"
ffmpeg -i "$combined_ts" -codec copy "$output_mp4" &>/dev/null

# Check for successful conversion
if [ $? -eq 0 ]; then
    print_msg "${GREEN}MP4 conversion successful! The video has been saved to: $output_mp4 🎥${NC}"
    rm "$combined_ts"
    print_msg "${GREEN}Removed combined TS file. 🧹${NC}"
else
    print_msg "${RED}MP4 conversion failed. Please check for errors. ❌${NC}"
fi

# Final message with the full path to the MP4 file
print_msg "${GREEN}Process completed! MP4 file created at: $output_mp4 🎉${NC}"