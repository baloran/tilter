module ApplicationHelper
  def embedded_svg(filename, options = {})
    assets = (Rails.application.assets ||
      ::Sprockets::Railtie.build_environment(Rails.application))
    file = assets.find_asset(filename).source.force_encoding('UTF-8')

    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    svg['class'] = options[:class] if options[:class].present?

    # rubocop:disable OutputSafety
    raw doc
    # rubocop:enable OutputSafety
  end
end
