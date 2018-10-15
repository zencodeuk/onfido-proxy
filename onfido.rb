require 'onfido'

class OnFido
  @api

  def initialize(token)
    Onfido.configure do |config|
      config.api_key = token
      config.api_version = 'v2'
      config.open_timeout = 30
      config.read_timeout = 80
    end

    @api = Onfido::API.new
  end

  def upload_documents applicant_id
    driving_licence = File.new('sample_driving_licence.png')
    sample_photo = File.new('sample_photo.png')
    document_response = @api.document.create(applicant_id, file: driving_licence, type: 'driving_licence', side: 'front')
    photo_response = @api.live_photo.create(applicant_id, file: sample_photo)

    return {photo: photo_response['href'], document: document_response['href']}
  end

  def list_documents applicant_id
    @api.document.all(applicant_id)
  end

  def create_applicant
    applicant_hash = {
      title: "Mr",
      first_name: "John",
      last_name: "Smith",
      gender: "male",
      dob: Date.new(2013, 2, 17),
      telephone: "02088909293",
      country: "GBR",
      addresses: [{
        building_number: 100,
        street: "Main Street",
        town: "London",
        postcode: "SW4 6EH",
        country: "GBR",
        start_date: Date.new(2013, 8, 10)
      }]
    }

    @api.applicant.create(applicant_hash)
  end
end

#puts OnFido.new().uploadDocuments('b9e22ce5-6639-4a2d-8b82-1aec1f110650')
