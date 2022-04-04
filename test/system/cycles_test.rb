require "application_system_test_case"

class CyclesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url "/"
    assert_selector ".cycles-table__row", count: Product.where(public_status: true).count
  end
end
