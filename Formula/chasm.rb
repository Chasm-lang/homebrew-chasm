class Chasm < Formula
  desc "Scripting language for real-time games — compiles to C99 with deterministic memory lifetimes"
  homepage "https://github.com/GarretTomlin/Chasm"
  url "https://github.com/GarretTomlin/Chasm/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "f84127fdcf3192484aef4035d2a0c4bb70cbe7c8c599bddfe2422397b26b1280"
  head "https://github.com/GarretTomlin/Chasm.git", branch: "main"
  license "MIT"
  version "1.2.1"

  bottle do
    root_url "https://github.com/Chasm-lang/homebrew-chasm/releases/download/v1.2.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "PLACEHOLDER_ARM64_SEQUOIA"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "PLACEHOLDER_ARM64_SONOMA"
    sha256 cellar: :any_skip_relocation, ventura:       "PLACEHOLDER_VENTURA"
  end

  depends_on "go" => :build

  def install
    # Bake the libexec path so CHASM_HOME is never needed at runtime
    system "go", "build",
      "-ldflags", "-X main.defaultChasmHome=#{libexec}",
      "-o", "#{bin}/chasm",
      "./cmd/cli"

    system "go", "build",
      "-o", "#{bin}/chasm-lsp",
      "./cmd/lsp"

    # Runtime assets — bootstrap binary, std lib, engine headers, examples
    libexec.install "bootstrap", "runtime", "std", "engine", "compiler", "examples", "editors"
  end

  def caveats
    <<~EOS
      Quick start:
        chasm run examples/hello_world.chasm
        chasm run --engine raylib examples/game/example.chasm
        chasm fmt myfile.chasm

      Install the VS Code / Cursor extension:
        code --install-extension #{libexec}/editors/vscode/chasm-language-0.3.0.vsix

      Or set chasm.serverPath in VS Code settings to:
        #{bin}/chasm-lsp
    EOS
  end

  test do
    (testpath/"hello.chasm").write <<~CHASM
      def main() do
        print(42)
      end
    CHASM
    assert_match "42", shell_output("#{bin}/chasm run #{testpath}/hello.chasm")
  end
end
