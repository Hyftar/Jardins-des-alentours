class DateFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.present? && value > DateTime.now
      record.errors.add(
        attribute,
        :invalid,
        {
          value: value,
          message: I18n.t("date_future")
        }
      )
    end
  end
end
