require "google/docs/table/version"

module Google
  module Docs
    module Table
      class Error < StandardError; end
      # Your code goes here...

      TABLE_CONTENT_START_INDEX = 4
      TABLE_COLUMN_GUTTER = 2
      TABLE_ROW_GUTTER = 1

      def self.create_insert_table_request(table_data, start_index)
        max_row = table_data.size
        max_col = table_data.max_by(&:size).size

        [
          {
            insert_table: {
              columns: max_col,
              rows: max_row,
              location: {
                index: start_index,
              },
            },
          },
        ] + create_request_for_insert_text(table_data, start_index, max_row, max_col)
      end

      def self.create_request_for_insert_text(table_data, start_index, max_row, max_col)
        input_values = parse_input_values(table_data, start_index, max_row, max_col)
        input_values.reverse.map do |value|
          if !value[:content].nil?
            { insert_text: { location: { index: value[:index] }, text: value[:content] } }
          end
        end.compact
      end

      def self.parse_input_values(table_data, start_index, max_row, max_col)
        start_index += TABLE_CONTENT_START_INDEX
        v = []
        (0..(max_row - 1)).each do |row|
          (0..(max_col - 1)).each do |col|
            if max_row > row && max_col > col && !table_data[row][col].nil?
              v.push(row: row, col: col, content: table_data[row][col], index: start_index)
            end
            start_index += TABLE_COLUMN_GUTTER
          end

          start_index += TABLE_ROW_GUTTER
        end

        v
      end
    end
  end
end
