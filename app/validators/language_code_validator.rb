class LanguageCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless I18nData.languages.key?(value.upcase)
      record.errors.add(
        attribute,
        :invalid,
        {
          value: value,
          message: I18n.t("invalid_language_code")
        }
      )
    end
  end
end
