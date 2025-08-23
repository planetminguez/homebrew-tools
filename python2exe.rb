class Python2exe < Formula
  desc "Convert Python scripts into native executables via a generated C wrapper"
  homepage "https://github.com/planetminguez/Python2ExeInC"
  head "https://github.com/planetminguez/Python2ExeInC.git", branch: "main"

  depends_on "python@3.12"

  def install
    cd "SimplePythonConverter" do
      system "make", "CC=#{ENV.cc}", "PREFIX=#{prefix}", "PYTHON_EXECUTABLE=#{Formula["python@3.12"].opt_bin}/python3"
      bin.install "python2exe"
    end
  end

  test do
    (testpath/"hello.py").write <<~PY
      #!/usr/bin/env python3
      import sys
      print("hello")
      if len(sys.argv) > 1:
          print(sys.argv[1])
    PY

    system bin/"python2exe", testpath/"hello.py"
    assert_path_exists testpath/"hello"

    output = shell_output("#{testpath}/hello world").strip
    assert_match "hello", output
    assert_match "world", output
  end
end

