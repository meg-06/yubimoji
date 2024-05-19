require 'test_helper'

class SignLanguageTest < ActiveSupport::TestCase
  test "should get correct yubimoji for hiragana" do
    hiragana = 'あ'
    sign_language = SignLanguage.find_by(character: hiragana)
    assert_equal 'assets/images/あ.png', sign_language.yubimoji
  end
end