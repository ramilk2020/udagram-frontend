# Use NodeJS base image
FROM beevelop/ionic AS ionic

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci


# Copy app source
COPY . .
RUN ionic build

# Bind the port that the image will run on
FROM nginx:alpine

# Define the Docker image's behavior at runtime
COPY --from=ionic /usr/src/app/www /usr/share/nginx/html
