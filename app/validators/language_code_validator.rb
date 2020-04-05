class LanguageCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.to_sym.in? I18n.available_locales
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
