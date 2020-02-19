class LanguageCodeValidator < ActiveModel::Validator
  def validate(record)
    unless I18nData.languages.key?(record.language.upcase)
      record.errors[:language] << I18n.t('invalid_language_code')
    end
  end
end
