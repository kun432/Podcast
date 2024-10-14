# Dockerfile
FROM python:3.12

# Set the working directory
WORKDIR /app

# Install Rust
RUN apt-get update && apt-get install -y curl && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    export PATH="$HOME/.cargo/bin:$PATH"

# Install FFmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Install required Python packages
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY . .

# Set environment variable from .env file
ENV OPENAI_API_KEY=${OPENAI_API_KEY}

# Expose port 8000
EXPOSE 8000

# Start the application
CMD ["uvicorn", "fast_api_app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
