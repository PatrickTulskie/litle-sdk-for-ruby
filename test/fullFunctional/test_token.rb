=begin
Copyright (c) 2012 Litle & Co.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
=end
require 'LitleOnline'
require 'test/unit'

class TestToken < Test::Unit::TestCase
  def test_simpleToken
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'orderId'=>'12344',
      'accountNumber'=>'1233456789101112'
    }
    response= LitleOnlineRequest.new.registerTokenRequest(hash)
    assert_equal('Valid Format', response.message)
  end

  def test_simpleTokenwithpaypage
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'orderId'=>'12344',
      'paypageRegistrationId'=>'1233456789101112'
    }
    response= LitleOnlineRequest.new.registerTokenRequest(hash)
    assert_equal('Valid Format', response.message)
  end

  def test_simpleTokenecheck
    hash = {
      'reportGroup'=>'Planets',
      'merchantId' => '101',
      'version'=>'8.8',
      'orderId'=>'12344',
      'echeckForToken'=>{'accNum'=>'12344565','routingNum'=>'123476545'}
    }
    response= LitleOnlineRequest.new.registerTokenRequest(hash)
    assert_equal('Valid Format', response.message)
  end

  def test_Tokenecheckmissingrequired
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'orderId'=>'12344',
      'echeckForToken'=>{'routingNum'=>'132344565'}
    }
    response= LitleOnlineRequest.new.registerTokenRequest(hash)
    assert(response.message =~ /Error validating xml data against the schema/)
  end

  def test_noReportGroup
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'orderId'=>'12344',
      'accountNumber'=>'1233456789101112',
    }
    exception = assert_raise(RuntimeError){LitleOnlineRequest.new.registerTokenRequest(hash)}
    assert_match /Missing Required Field: @reportGroup!!!!/, exception.message

  end

  def test_accountNumandPaypage
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'orderId'=>'12344',
      'accountNumber'=>'1233456789101112',
      'paypageRegistrationId'=>'1233456789101112'
    }
    exception = assert_raise(RuntimeError){LitleOnlineRequest.new.registerTokenRequest(hash)}
    assert_match /Entered an Invalid Amount of Choices for a Field, please only fill out one Choice!!!!/, exception.message
  end

  def test_echeckandPaypage
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'orderId'=>'12344',
      'echeckForToken'=>{'accNum'=>'12344565','routingNum'=>'123476545'},
      'paypageRegistrationId'=>'1233456789101112'
    }
    exception = assert_raise(RuntimeError){LitleOnlineRequest.new.registerTokenRequest(hash)}
    assert_match /Entered an Invalid Amount of Choices for a Field, please only fill out one Choice!!!!/, exception.message
  end

  def test_echeckandPaypageandaccountnum
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'reportGroup'=>'Planets',
      'orderId'=>'12344',
      'accountNumber'=>'1233456789101112',
      'echeckForToken'=>{'accNum'=>'12344565','routingNum'=>'123476545'},
      'paypageRegistrationId'=>'1233456789101112'
    }
    exception = assert_raise(RuntimeError){LitleOnlineRequest.new.registerTokenRequest(hash)}
    assert_match /Entered an Invalid Amount of Choices for a Field, please only fill out one Choice!!!!/, exception.message
  end

  def test_FieldsOutOfOrder
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'orderId'=>'12344',
      'accountNumber'=>'1233456789101112',
      'reportGroup'=>'Planets',
    }
    response= LitleOnlineRequest.new.registerTokenRequest(hash)
    assert_equal('Valid Format', response.message)
  end

  def test_InvalidField
    hash = {
      'merchantId' => '101',
      'version'=>'8.8',
      'NOSUCHFIELD'=>'none',
      'orderId'=>'12344',
      'accountNumber'=>'1233456789101112',
      'reportGroup'=>'Planets',
    }
    response= LitleOnlineRequest.new.registerTokenRequest(hash)
    assert_equal('Valid Format', response.message)
  end
end

