FROM node:18

# # Create a non-root user and group
# RUN addgroup --system appgroup && adduser --system appuser --ingroup appgroup

# # Switch to the non-root user
# USER appuser

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json .

# Install project dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY src ./src
COPY public ./public

# Expose the port the app runs on (default for many Node.js apps is 3000)
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
