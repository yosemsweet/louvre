#!/usr/bin/env ruby
#
# Mixpanel, Inc. -- http://mixpanel.com/
#
# This library is used for adding tracking code to HTML email bodies.

require 'net/http'
require 'json'
require 'uri'

class MixpanelEmail

    ENDPOINT = 'http://api.mixpanel.com/email'

    def initialize(token, campaign, options={})
        @params = {}
        @params['token'] = token
        @params['campaign'] = campaign
        if options[:type] == 'text'
            @params['type'] = 'text'
        end
        if options[:properties]
            @params['properties'] = JSON.generate(options[:properties])
        end
        if options[:redirect_host]
            @params['redirect_host'] = options[:redirect_host]
        end
        if options[:click_tracking] == false
            @params['click_tracking'] = '0'
        end
    end

    def add_tracking(distinct_id, body)
        p = @params.dup()
        p['distinct_id'] = distinct_id
        p['body'] = body
        response = Net::HTTP.post_form(URI.parse(MixpanelEmail::ENDPOINT), p)
        case response
        when Net::HTTPSuccess
            response.body
        else
            response.error!
        end
    end

end

#api = MixpanelEmail.new('YOUR TOKEN HERE', 'YOUR CAMPAIGN HERE')
#example = <<end
#<p>Hi User,</p>
#<p>This is a sample email from <a href="http://example.com/">example.com</a>.</p>
#<p>Each anchor link will be replaced with a tracking redirect when filtered with
#<a href="http://mixpanel.com/">Mixpanel's</a> email tracking service.</p>
#--<br>
#Signature<br>
#end
#print api.add_tracking('test_user@example.com', example)