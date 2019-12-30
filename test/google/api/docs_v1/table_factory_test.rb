require "test_helper"

class Google::Api::DocsV1::TableFactoryTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Google::Api::DocsV1::TableFactory::VERSION
  end

  def test_it_has_correct_insert_text_requests_when_table_data_has_all_cells_filled
    table_data = [['A1', 'B1'], ['A2', 'B2']]

    actual = ::Google::Api::DocsV1::TableFactory.insert_table_request(index: 1, table_data: table_data)

    assert_equal(actual,
      [
        { insert_table: { columns: 2, rows: 2, location: { index: 1 } } },
        { insert_text: { location: { index: 12 }, text: 'B2' } },
        { insert_text: { location: { index: 10 }, text: 'A2' } },
        { insert_text: { location: { index: 7 }, text: 'B1' } },
        { insert_text: { location: { index: 5 }, text: 'A1' } },
      ],
    )
  end

  def test_it_has_correct_insert_text_requests_when_table_data_has_some_empty_cells
    table_data = [['A1', 'B1', 'C1'], [nil, 'B2', nil], ['A3', 'B3', 'C3']]

    actual = ::Google::Api::DocsV1::TableFactory.insert_table_request(index: 1, table_data: table_data)

    assert_equal(actual,
      [
        { insert_table: { columns: 3, rows: 3, location: { index: 1 } } },
        { insert_text: { location: { index: 23 }, text: 'C3' } },
        { insert_text: { location: { index: 21 }, text: 'B3' } },
        { insert_text: { location: { index: 19 }, text: 'A3' } },
        { insert_text: { location: { index: 14 }, text: 'B2' } },
        { insert_text: { location: { index: 9 }, text: 'C1' } },
        { insert_text: { location: { index: 7 }, text: 'B1' } },
        { insert_text: { location: { index: 5 }, text: 'A1' } },
      ],
    )
  end
end
