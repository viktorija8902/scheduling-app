class SelectedBabysittingTime < ApplicationRecord

	def self.update_available_times(params, babysitter_id)
	  	babysitting_day = params.dig('babysitting_day')
	  	babysitting_times = params.dig('babysitting_time') || []

	  	delete_previously_selected_times(babysitter_id, babysitting_day)
	  	create_available_times(babysitter_id, babysitting_day, babysitting_times)
	end

	def self.delete_previously_selected_times(babysitter_id, babysitting_day)
		SelectedBabysittingTime.where(babysitter_id: babysitter_id, babysitting_day_id: babysitting_day).find_each do |available_time|
		  available_time.destroy
		end
	end

	def self.create_available_times(babysitter_id, babysitting_day, babysitting_times)
		for babysitting_time in babysitting_times
	  		SelectedBabysittingTime.create!(
	  			babysitter_id: babysitter_id,
				babysitting_day_id: babysitting_day,
				babysitting_time_id: babysitting_time
	  		)
	  	end
  	end
end