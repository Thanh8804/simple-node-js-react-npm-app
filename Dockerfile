FROM node:18

# Create a non-root user and group
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json as root (for now)
COPY package.json ./

# Ensure the /app directory is owned by appuser
RUN chown -R appuser:appgroup /app

# Switch to non-root user for subsequent commands
USER appuser

# Install project dependencies as appuser
RUN npm install

# Copy the rest of the application code (as appuser)
COPY --chown=appuser:appgroup src ./src
COPY --chown=appuser:appgroup public ./public

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
