class Track < ActiveRecord::Base
  self.table_name = :storyline

  belongs_to :user
  belongs_to :merged_into, class_name: Track
  has_many :merged_tracks, class_name: Track, foreign_key: :merged_into_id

  scope :confirmed,   -> { where('confirmed_at IS NOT NULL') }
  scope :unconfirmed, -> { where('confirmed_at IS NULL') }
  scope :merged,      -> { where('merged_into_id IS NULL') }
  scope :not_deleted, -> { where('merged_into_id IS NULL AND NOT misdetected_completely') }

  scope :detected, -> { where('detected_mode IS NOT NULL') }
  scope :manual, -> { where('detected_mode IS NULL') }

  def self.first_of_day?(track)
    !where('started_at < ?', track.started_at)
      .where(started_on: track.started_on)
      .exists?
  end

  def mode_name
    mode.name
  end

  def mode_icon
    mode.icon
  end

  def mode_edited?
    mode != detected_mode
  end

  def detected_mode_name
    detected_mode && detected_mode.name
  end

  def detected_mode
    Mode.from_id(read_attribute(:detected_mode)) if read_attribute(:detected_mode).present?
  end

  def mode
    Mode.from_id(read_attribute(:mode)) if read_attribute(:mode).present?
  end

  def confirmed?
    !!confirmed_at
  end

  def unconfirmed?
    !confirmed?
  end

  def confirm
    touch(:confirmed_at)
  end

  def unconfirm
    update(confirmed_at: nil)
  end

  def editable?
    unconfirmed? && !readonly?
  end

  def manually_added?
    !detected?
  end

  def detected?
    !!detected_mode
  end

  def kilometers
    (length || 0) / 1000.0
  end

  def carbon_emission
    mode.carbon_emission_per_kilometer * kilometers
  end

  def duration
    finished_at - started_at
  end

  def num_points
    return 0 if geometry.nil?

    if geometry.respond_to?(:num_points)
      geometry.num_points
    else
      geometry.sum(&:num_points)
    end
  end

  def start_point
    return nil unless geometry
    (
      RGeo::Feature::GeometryCollection.check_type(geometry) ? geometry.first : geometry
    ).points.first
  end

  def straight_line?
    return false if num_points.zero?
    length / num_points > 500
  end

  def count
    1
  end

  def deleted?
    misdetected_completely?
  end

  def has_merged_tracks?
    !merge_count.zero?
  end

  def belongs_to_previous?
    !!merged_into_id
  end

  def preceding
    same_day_tracks
      .to_a
      .reverse
      .reject(&:belongs_to_previous?)
      .reject(&:misdetected_completely?)
      .detect { |t| t.started_at < started_at }
  end

  # Is this the last track of the user?
  def last?
    !user
      .tracks
      .not_deleted
      .where('started_at > ?', started_at)
      .exists?
  end

  private

  def same_day_tracks
    fail('Unexpected nil started_on. Call reload explicitly?') unless started_on
    user.tracks.where(started_on: started_on).order(:started_at)
  end

  def multi_line_string(line_strings)
    line_strings.first.factory.multi_line_string(line_strings)
  end
end
