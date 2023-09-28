class PipTools < Formula
  include Language::Python::Virtualenv

  desc "Locking and sync for Pip requirements files"
  homepage "https://pip-tools.readthedocs.io"
  url "https://files.pythonhosted.org/packages/fd/01/f0055058a86a888f32ac794fa68d5a25c2d2f7a3e8181474b711faaa2145/pip-tools-7.3.0.tar.gz"
  sha256 "8e9c99127fe024c025b46a0b2d15c7bd47f18f33226cf7330d35493663fc1d1d"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3bec39e5c4482d9aae424cad1f1f9d1f42e6e6da330510156bd1a400d917277d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e5a87e49ded3a833a5f2164b780767766be1d95b2c21e28a943a9fbb78184867"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a5b8f7e01939d417be4c86416ff48229f7b6899fd020b79adb634dfce68670b4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3e9c65943403e4e2f73f87d87dd20501cf36968c8518e7c626fc53705a5ff8fa"
    sha256 cellar: :any_skip_relocation, sonoma:         "c4ec76dfbd0abf331182518c650bc686f09cc24f2e76dbc7848c0783b466cb08"
    sha256 cellar: :any_skip_relocation, ventura:        "5f0bbd89c3e25c5b3efdd64b4ec5685c23fd200b723fd55333bf7bd3dcefafa1"
    sha256 cellar: :any_skip_relocation, monterey:       "b0baaabdb842e6c156c7b89ac693f2c7dcc515035e25ce18ffc3044047b33d2e"
    sha256 cellar: :any_skip_relocation, big_sur:        "dbe3335b21cd09571ebd3a70576557a3a7b3bede918b6bf3d688ead5e90bb0ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b9d3b7eac1386ee0ba793f4068ffc0b630aca310dd320414eaac53e910a5ae4e"
  end

  depends_on "python@3.11"

  resource "build" do
    url "https://files.pythonhosted.org/packages/de/1c/fb62f81952f0e74c3fbf411261d1adbdd2d615c89a24b42d0fe44eb4bcf3/build-0.10.0.tar.gz"
    sha256 "d5b71264afdb5951d6704482aac78de887c80691c52b88a9ad195983ca2c9269"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/72/bd/fedc277e7351917b6c4e0ac751853a97af261278a4c7808babafa8ef2120/click-8.1.6.tar.gz"
    sha256 "48ee849951919527a045bfe3bf7baa8a959c423134e1a5b98c05c20ba75a1cbd"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/b9/6c/7c6658d258d7971c5eb0d9b69fa9265879ec9a9158031206d47800ae2213/packaging-23.1.tar.gz"
    sha256 "a392980d2b6cffa644431898be54b0045151319d1e7ec34f0cfed48767dd334f"
  end

  resource "pyproject-hooks" do
    url "https://files.pythonhosted.org/packages/25/c1/374304b8407d3818f7025457b7366c8e07768377ce12edfe2aa58aa0f64c/pyproject_hooks-1.0.0.tar.gz"
    sha256 "f271b298b97f5955d53fb12b72c1fb1948c22c1a6b70b315c54cedaca0264ef5"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/c9/3d/02a14af2b413d7abf856083f327744d286f4468365cddace393a43d9d540/wheel-0.41.1.tar.gz"
    sha256 "12b911f083e876e10c595779709f8a88a59f45aacc646492a67fe9ef796c1b47"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      pip-tools
      typing-extensions
    EOS

    compiled = shell_output("#{bin}/pip-compile requirements.in -q -o -")
    assert_match "This file is autogenerated by pip-compile", compiled
    assert_match "# via pip-tools", compiled
  end
end
