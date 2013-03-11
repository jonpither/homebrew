require 'formula'

class Datomic < Formula
  homepage ''
  url 'http://downloads.datomic.com/0.8.3826/datomic-free-0.8.3826.zip'
  sha1 '284466c5e1b8e843433f71260b81127d3a9fa464'

  def install
    prefix.install Dir['*']

    inreplace "#{prefix}/config/samples/free-transactor-template.properties" do |s|
      s.gsub! /#data-dir=.*$/, "data-dir=#{var}/datomic"
      s.gsub! /#log-dir=.*$/, "log-dir=#{var}/log/datomic/"
    end

  end

  def plist; <<-EOS.undent
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <true/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>bin/transactor</string>
            <string>#{prefix}/config/samples/free-transactor-template.properties</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>UserName</key>
          <string>#{ENV['USER']}</string>
          <key>WorkingDirectory</key>
          <string>#{prefix}</string>
          <key>StandardErrorPath</key>
          <string>/dev/null</string>
          <key>StandardOutPath</key>
          <string>/dev/null</string>
        </dict>
      </plist>
    EOS
  end

end
