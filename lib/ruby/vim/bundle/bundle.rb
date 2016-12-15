require 'uri'

class Bundle < OpenStruct
  def uri
    @uri ||= URI.parse(url)
  end

  def destination
    @destination ||= BUNDLES_DIR + name
  end

  def task_name
    @task_name ||= destination
  end
end
