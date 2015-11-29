require 'rails_helper'

RSpec.describe Labeling, type: :model do 
	it {should belong_to :labelable}  # Labelable is an interface
	
end