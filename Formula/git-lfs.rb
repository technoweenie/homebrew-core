class GitLfs < Formula
  desc "Git extension for versioning large files"
  homepage "https://github.com/github/git-lfs"
  url "https://github.com/github/git-lfs/archive/v1.4.1.tar.gz"
  sha256 "5c2b6640d965a0ed334c6a7e4a5e327c7543234d3f2a2c7879d5b9731ef82c4b"

  bottle do
    cellar :any_skip_relocation
    sha256 "1f3d861e5b2d401073c25afa27e77162532c2981f189e1f1e1947ed5adbcbefd" => :el_capitan
    sha256 "b0b9de80df3bef7e0cfc7ee5bcc2e3a7042f5aae6aee3f7f5a73118275ff7e6b" => :yosemite
    sha256 "2a05ea3c7aca321dd502a6b93bfe997a048216183edc09b7170939f6587cd961" => :mavericks
  end

  depends_on "go" => :build

  def install
    system "./script/bootstrap"
    bin.install "bin/git-lfs"
  end

  def caveats; <<-EOS.undent
    Update your git config to finish installation:

      # Update global git config
      $ git lfs install

      # Update system git config
      $ git lfs install --system
    EOS
  end

  test do
    system "git", "init"
    system "git", "lfs", "track", "test"
    assert_match(/^test filter=lfs/, File.read(".gitattributes"))
  end
end
