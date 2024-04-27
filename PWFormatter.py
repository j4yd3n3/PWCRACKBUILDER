
import sys

def process_file(input_filename, output_filename):
    try:
        with open(input_filename, 'r') as file:
            lines = file.readlines()
        
        # Remove duplicates and strip newline characters
        unique_lines = list(set(line.strip() for line in lines))

        processed_lines = set()

        for line in unique_lines:
            # As is but lowercase
            processed_lines.add(line.lower())
            
            # Replace spaces with underscores and lowercase
            processed_lines.add(line.replace(" ", "_").lower())
            
            # Remove spaces and lowercase
            processed_lines.add(line.replace(" ", "").lower())

        # Write the processed lines to the output file
        with open(output_filename, 'w') as out_file:
            for line in sorted(processed_lines):
                out_file.write(line + '\n')

    except FileNotFoundError:
        print(f"Error: The file {input_filename} does not exist.")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("No arguments provided. Please provide an input filename and an output filename.")
        sys.exit(1)
    
    input_filename = sys.argv[1]
    output_filename = sys.argv[2]
    process_file(input_filename, output_filename)
