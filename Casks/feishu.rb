cask "feishu" do
  if Hardware::CPU.intel?
    version "4.7.7,4a091c"
    sha256 "dc6b07ddc1917c289630872700a7940c6d2f6b4df25e202fa3b682f6fd37b971"

    url "https://sf3-cn.feishucdn.com/obj/ee-appcenter/#{version.after_comma}/Feishu-darwin_x64-#{version.before_comma}-signed.dmg",
        verified: "sf3-cn.feishucdn.com/"

    livecheck do
      url "https://www.feishu.cn/api/downloads"
      strategy :page_match do |page|
        match = page.match(%r{/(\h+)/Feishu-darwin_x64-(\d+(?:\.\d+)*)-signed\.dmg}i)
        "#{match[2]},#{match[1]}"
      end
    end
  else
    version "4.6.4,09dbe9"
    sha256 "715116886e220a8c2be4034f85a027a6ce24eb1f36efeaa16fdc29cac87aa7c4"

    url "https://sf3-cn.feishucdn.com/obj/ee-appcenter/#{version.after_comma}/Feishu-darwin_arm64-#{version.before_comma}-signed.dmg",
        verified: "sf3-cn.feishucdn.com/"

    livecheck do
      url "https://www.feishu.cn/api/downloads"
      strategy :page_match do |page|
        match = page.match(%r{/(\h+)/Feishu-darwin_arm64-(\d+(?:\.\d+)*)-signed\.dmg}i)
        "#{match[2]},#{match[1]}"
      end
    end
  end

  name "feishu"
  desc "Project management software"
  homepage "https://www.feishu.cn/"

  auto_updates true

  # Renamed for consistency: app name is different in the Finder and in a shell.
  app "Lark.app", target: "Feishu.app"

  zap trash: [
    # feishu
    "~/Library/Caches/com.bytedance.lark.helper",
    "~/Library/Preferences/com.bytedance.lark.helper.plist",
    # lark
    "~/Library/Caches/com.electron.lark.helper",
    "~/Library/Preferences/com.electron.lark.helper.plist",
    # both
    "~/Library/Caches/com.electron.lark",
    "~/Library/Saved Application State/com.electron.lark.savedState",
  ]
end
