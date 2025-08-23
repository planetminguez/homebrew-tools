# Makefile for Python to Executable Converter
# C program that converts Python scripts to standalone executables

# Compiler and build settings
CC ?= clang
CFLAGS ?= -Wall -Wextra -Wno-unused-variable -O2 -std=c99

# Installation prefixes (overridable)
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

# Python interpreter to bake into generated wrappers (overridable)
PYTHON_EXECUTABLE ?= /usr/bin/python3

# Version (from VERSION file if present)
VERSION := $(shell [ -f VERSION ] && cat VERSION || echo 0.1.0)
CFLAGS += -std=c99 -DVERSION=\"$(VERSION)\" -DPYTHON_EXECUTABLE=\"$(PYTHON_EXECUTABLE)\"

# Target executable
TARGET = python2exe
SOURCE = python2exe.c

# Default target
all: $(TARGET)

# Build the main executable
$(TARGET): $(SOURCE)
	@echo "🔨 Compiling Python to Executable Converter..."
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)
	@echo "✅ Build complete! Executable: $(TARGET)"

# Install (respects PREFIX/DESTDIR)
install: $(TARGET)
	@echo "📦 Installing $(TARGET) to $(DESTDIR)$(BINDIR)..."
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(TARGET) $(DESTDIR)$(BINDIR)/$(TARGET)
	@echo "✅ Installation complete! You can now run 'python2exe' from $(BINDIR)."

# Remove installation
uninstall:
	@echo "🗑️  Removing $(TARGET) from $(DESTDIR)$(BINDIR)..."
	rm -f $(DESTDIR)$(BINDIR)/$(TARGET)
	@echo "❌ Uninstallation complete."

# Clean build artifacts
clean:
	@echo "🧹🧹🧹 Cleaning build artifacts..."
	rm -f $(TARGET)
	rm -f *.o
	rm -f test_*
	@echo "✅ Clean complete."

# Create test Python script
create-test:
	@echo "🐍 Creating test Python script...🐍"
	@echo '#!/usr/bin/env python3' > test_hello.py
	@echo 'print("Hello from Python executable!")' >> test_hello.py
	@echo 'import sys' >> test_hello.py
	@echo 'if len(sys.argv) > 1:' >> test_hello.py
	@echo '    args = " ".join(sys.argv[1:])' >> test_hello.py
	@echo '    print(f"Arguments: {args}")' >> test_hello.py
	@echo "✅ Created test_hello.py"

# Advanced test script with user input
create-advanced-test:
	@echo "🐍 Creating advanced test Python script...🐍"
	@echo '#!/usr/bin/env python3' > test_calculator.py
	@echo 'import sys' >> test_calculator.py
	@echo '' >> test_calculator.py
	@echo 'if len(sys.argv) != 4:' >> test_calculator.py
	@echo '    print("Usage: calculator.py <num1> <op> <num2>")' >> test_calculator.py
	@echo '    print("Operations: +, -, *, /")' >> test_calculator.py
	@echo '    sys.exit(1)' >> test_calculator.py
	@echo '' >> test_calculator.py
	@echo 'try:' >> test_calculator.py
	@echo '    num1 = float(sys.argv[1])' >> test_calculator.py
	@echo '    op = sys.argv[2]' >> test_calculator.py
	@echo '    num2 = float(sys.argv[3])' >> test_calculator.py
	@echo '    ' >> test_calculator.py
	@echo '    if op == "+":' >> test_calculator.py
	@echo '        result = num1 + num2' >> test_calculator.py
	@echo '    elif op == "-":' >> test_calculator.py
	@echo '        result = num1 - num2' >> test_calculator.py
	@echo '    elif op == "*":' >> test_calculator.py
	@echo '        result = num1 * num2' >> test_calculator.py
	@echo '    elif op == "/":' >> test_calculator.py
	@echo '        if num2 == 0:' >> test_calculator.py
	@echo '            print("Error: Division by zero!")' >> test_calculator.py
	@echo '            sys.exit(1)' >> test_calculator.py
	@echo '        result = num1 / num2' >> test_calculator.py
	@echo '    else:' >> test_calculator.py
	@echo '        print(f"Error: Unknown operation {op}")' >> test_calculator.py
	@echo '        sys.exit(1)' >> test_calculator.py
	@echo '    ' >> test_calculator.py
	@echo '    print(f"{num1} {op} {num2} = {result}")' >> test_calculator.py
	@echo 'except ValueError:' >> test_calculator.py
	@echo '    print("Error: Invalid number format")' >> test_calculator.py
	@echo '    sys.exit(1)' >> test_calculator.py
	@echo "✅ Created test_calculator.py"

# Test with simple script
test: $(TARGET) create-test
	@echo "🧪 Testing Python to Executable conversion..."
	./$(TARGET) test_hello.py
	@echo ""
	@echo "🏃 Testing generated executable..."
	./test_hello "arg1" "arg2"

# Test with advanced script
test-advanced: $(TARGET) create-advanced-test
	@echo "🧪 Testing advanced Python to Executable conversion...🧪"
	./$(TARGET) test_calculator.py
	@echo ""
	@echo "Testing calculator executable..."
	./test_calculator 5 + 3

# Show usage
help: $(TARGET)
	@echo "📖 Python to Executable Converter Help:"
	@echo ""
	./$(TARGET) --help

# Show build information
info:
	@echo "  Build Information:"
	@echo "  Compiler: $(CC)"
	@echo "  Flags: $(CFLAGS)"
	@echo "  Target: $(TARGET)"
	@echo "  Source: $(SOURCE)"
	@echo "  Version: $(VERSION)"
	@echo "  Prefix: $(PREFIX)"
	@echo "  Bindir: $(BINDIR)"
	@echo "  Python: $(PYTHON_EXECUTABLE)"

# Batch convert all Python files in current directory
batch-convert: $(TARGET)
	@echo "🔄 Converting all Python files to executables... 🔄"
	@for py_file in *.py; do \
		if [ -f "$$py_file" ]; then \
			echo "Converting $$py_file..."; \
			./$(TARGET) "$$py_file"; \
		fi; \
	done
	@echo "✅ Batch conversion complete!"

.PHONY: all install uninstall clean create-test create-advanced-test test test-advanced help info batch-convert
