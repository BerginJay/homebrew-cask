cask "appcode" do
  version "2021.2,212.4746.137"

  if Hardware::CPU.intel?
    sha256 "012651472e9f84fd7a33fae0208e03dbb61495067a4e274bc4444248210afc2d"

    url "https://download.jetbrains.com/objc/AppCode-#{version.before_comma}.dmg"
  else
    sha256 "c53f33bf97f1a6e600f0ce379e7ed743e9995867bb757539a8ec08ae45eb61e0"

    url "https://download.jetbrains.com/objc/AppCode-#{version.before_comma}-aarch64.dmg"
  end

  name "AppCode"
  desc "IDE for Swift, Objective-C, C, and C++ development"
  homepage "https://www.jetbrains.com/objc/"

  livecheck do
    url "https://data.services.jetbrains.com/products/releases?code=AC&latest=true&type=release"
    strategy :page_match do |page|
      JSON.parse(page)["AC"].map do |release|
        "#{release["version"]},#{release["build"]}"
      end
    end
  end

  auto_updates true
  depends_on macos: ">= :high_sierra"

  app "AppCode.app"

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "appcode") }.each do |path|
      if File.exist?(path) &&
         File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/AppCode#{version.major_minor}",
    "~/Library/Caches/AppCode#{version.major_minor}",
    "~/Library/Logs/AppCode#{version.major_minor}",
    "~/Library/Preferences/AppCode#{version.major_minor}",
  ]
end
