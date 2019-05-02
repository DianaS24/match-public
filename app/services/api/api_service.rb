module Api
  class ApiService
    def top_teams_format(teams)
      response = obtain_base_object.clone
      response['data'] = []
      teams.each do |team|
        response['data'].push(
          name: team.name,
          value: team.score
        )
      end
      response.to_json
    end

    def winner_team(team)
      response = obtain_label_object.clone
      response['data'] = []
      response['postfix'] = "Score #{team&.first&.score}"
      response['data'] = {
        value: team.first.name
      }
      response.to_json
    end

    def last_activity_format(activity)
      activity_type = activity.activity_type == 'Post' ? 'Post' : get_activity_type_en(activity.activity_type)
      response = obtain_label_object.clone
      response['data'] = []
      response['postfix'] = "Team #{activity.user.current_team&.name} - #{activity_type}"
      response['data'] = {
        value: activity.name
      }
      response.to_json
    end

    def top_activities_format(activity)
      response = obtain_base_object.clone
      response['data'] = []
      response['valueNameHeader'] = 'Activities'
      response['valueHeader'] = 'TOP 3'
      activity.each_with_index do |activities, index|
        response['data'].push(
          name: "#{Activity.activity_types.keys[index]}-#{activities.first&.name}",
          value: activities.first&.points
        )
      end
      response.to_json
    end

    private

    def get_activity_type_en(activity_type)
      activity_type == 'Curso' ? 'Course' : 'Talk'
    end

    def obtain_base_object
      {
        "valueNameHeader": 'TEAMS',
        "valueHeader": 'TOP 5',
        "color": 'red',
        "data": [
          {
            "name": 'Jean-Luc Picard',
            "value": 1450
          },
          {
            "name": 'James Kirk',
            "value": 350
          }
        ]
      }
    end

    def obtain_label_object
      {
        "postfix": 'MyUnits',
        "color": 'blue',
        "data": {
          "value": 1234
        }
      }
    end
  end
end
