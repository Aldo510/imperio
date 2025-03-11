require "test_helper"

class TrainingFormsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get training_forms_new_url
    assert_response :success
  end

  test "should get generate_pdf" do
    get training_forms_generate_pdf_url
    assert_response :success
  end
end
