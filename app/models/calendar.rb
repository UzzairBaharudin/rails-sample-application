class Calendar < ActiveRecord::Base
  has_many :events, -> { order('created_at DESC') }, dependent: :destroy
  has_many :calendar_users
  belongs_to :user

  before_validation :check_something

  validates_format_of :name, :with => /\A[a-z A-Z]+\z/,  :message => "Please use only regular letters as name"


  def as_json(options= {})
    {id: self.id, text: self.name}
  end

  def self.import(file)
    # CSV.foreach(file.path, headers: true) do |row|
    #   Calendar.create! row.to_hash
    # end

    CSV.foreach(file.path, headers: true) do |row|
      calendar = find_by_id(row['id']) || new
      calendar.attributes = row.to_hash
      calendar.save!
    end
  end

  def self.to_csv(option = {})
    CSV.generate(option) do |csv|
      csv << column_names
      all.each do |calendar|
        csv << calendar.attributes.values_at(*column_names)
      end
    end
  end

  def self.range_events
    where(created_at: (Time.now.midnight - 30.day)..Time.now.midnight)
  end

  def check_something
    p 'Check Some Things ..... ******************'
  end
end




# http://railscasts.com/episodes/362-exporting-csv-and-excel

# http://railscasts.com/episodes/396-importing-csv-and-excel
# https://github.com/roo-rb/roo