#!/bin/bash

# Function to list files sorted by size
list_files() {
  echo "Listing files sorted by size (ascending):"
  ls -lS
  echo ""
  echo "Listing files sorted by size (descending):"
  ls -lSr
  echo ""
}

# Function to count files by extension and total size
count_files_by_extension() {
  echo "Counting files by extension and total size..."
  total_size=0
  declare -A ext_count

  # Loop through all files
  for file in *.*; do
    if [ -f "$file" ]; then
      ext="${file##*.}"
      size=$(stat -c %s "$file")
      total_size=$((total_size + size))
      ext_count["$ext"]=$((ext_count["$ext"] + 1))
    fi
  done

  # Display counts
  for ext in "${!ext_count[@]}"; do
    echo "${ext_count[$ext]} .${ext} files"
  done

  # Display total size in MB
  echo "Total size: $((total_size / 1024 / 1024)) MB"
  echo ""
}

# Function to show folder total size
folder_total_size() {
  folder_size=$(du -sh . | cut -f1)
  echo "Folder total size: $folder_size"

  # Check if size exceeds X (for example, 500 MB)
  X=500
  folder_size_mb=$(du -sm . | cut -f1)

  if [ "$folder_size_mb" -gt "$X" ]; then
    echo "Warning: Folder size exceeds ${X}MB!"
    # Ask for compression or deletion
    echo "You can compress or delete unnecessary files."
    echo "Would you like to compress files? (y/n)"
    read response
    if [ "$response" == "y" ]; then
      echo "Compressing files..."
      # Compressing all files into a tar.gz archive
      tar -czf backup.tar.gz *
      echo "Files compressed to backup.tar.gz"
    elif [ "$response" == "n" ]; then
      echo "No action taken."
    fi
  fi
}

# Main script
list_files
count_files_by_extension
folder_total_size

echo "  "
echo "1) Utilitiy Script"
echo "2) Read file script.sh"
echo "3) Delete Script"
echo "4) Quit"

