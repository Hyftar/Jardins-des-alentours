class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless /\A[^@\s]+@[^@\s]+\z/ =~ value
        record.errors.add(
          attribute,
          :invalid,
          {
            value: value,
            message: I18n.t('invalid_email')
          }
        )
      end
    end
  end
