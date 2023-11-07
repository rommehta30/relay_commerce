module QuotaHandler
  extend ActiveSupport::Concern

  MAX_ALLOWED_HITS_PER_MONTH = 10000

  private

  def register_hit
    Rails.cache.write("#{current_user.id}_hits_count", hits_count, expires_at: Time.current.end_of_month)
    # Todo: Add logic to insert hit
  end

  def check_user_quota
    render_400(I18n.t('en.errors.messages.quota_reached')) if hits_count > MAX_ALLOWED_HITS_PER_MONTH
  end

  def hits_count
    count = Rails.cache.read("#{current_user.id}_hits_count")
    @hits_count ||= count.nil? ? 1 : count + 1
  end
end
