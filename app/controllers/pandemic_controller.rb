class PandemicController < ApplicationController
  def index
    api_url = "https://api.covidtracking.com/v1/states/current.json"
    raw_data = URI.open(api_url).read
    @states = JSON.parse(raw_data)
    @data_date = Date.parse(@states.at(0).fetch("date").to_s)
    
    render("pandemic_templates/state_list")
  end

  def details
    @state = params.fetch("state")

    api_url = "https://api.covidtracking.com/v1/states/#{@state.downcase}/daily.json"
    raw_data = URI.open(api_url).read
    date_data = JSON.parse(raw_data)

    @data_array = [
      ['Date', 'Percent of new tests comprised of new positive cases']
    ]

    date_data.reverse.each do |date|
      positive_increase = date.fetch("positiveIncrease")
      
      total_test_result_increase = date.fetch("totalTestResultsIncrease")
      
      if total_test_result_increase != 0
        percent_tests_positive = 100 * positive_increase.to_f / total_test_result_increase
      else
        percent_tests_positive = nil
      end

      @data_array.push(
        [
          Date.parse(date.fetch("date").to_s),
          # positive_increase,
          # total_test_result_increase,
          percent_tests_positive
        ]
      )
    end

    @tutorial_code = <<-HTML
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart);

  function drawChart() {
    var data = google.visualization.arrayToDataTable(<%= raw(@data_array.to_json) %>);

    var options = {
      title: 'Percent of new tests comprised of new positive cases',
      legend: { position: 'bottom' }
    };

    var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

    chart.draw(data, options);
  }
</script>

<div id="curve_chart" style="width: 900px; height: 500px"></div>
HTML

    render("pandemic_templates/state_details")
  end
end
