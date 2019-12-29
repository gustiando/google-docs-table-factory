require "google/api/docs_v1/table_factory/version"

module Google
  module Api
    module DocsV1
      module TableFactory
        class Error < StandardError; end

        TABLE_CONTENT_INDEX = 4
        TABLE_COLUMN_GUTTER = 2
        TABLE_ROW_GUTTER = 1

        def self.insert_table_request(table_data:, index:)
          max_row = table_data.size
          max_col = table_data.max_by(&:size).size

          [
            {
              insert_table: {
                columns: max_col,
                rows: max_row,
                location: {
                  index: index,
                },
              },
            },
          ] + request_for_insert_text(
            table_data: table_data,
            index: index,
            max_row: max_row,
            max_col: max_col,
          )
        end

        def self.request_for_insert_text(table_data:, index:, max_row:, max_col:)
          input_values = parse_input_values(
            table_data: table_data,
            index: index,
            max_row: max_row,
            max_col: max_col,
          )

          input_values.reverse.map do |value|
            if !value[:content].nil?
              { insert_text: { location: { index: value[:index] }, text: value[:content] } }
            end
          end.compact
        end

        def self.parse_input_values(table_data:, index:, max_row:, max_col:)
          index += TABLE_CONTENT_INDEX
          v = []
          (0..(max_row - 1)).each do |row|
            (0..(max_col - 1)).each do |col|
              if max_row > row && max_col > col && !table_data[row][col].nil?
                v.push(row: row, col: col, content: table_data[row][col], index: index)
              end
              index += TABLE_COLUMN_GUTTER
            end

            index += TABLE_ROW_GUTTER
          end

          v
        end
      end
    end
  end
end
