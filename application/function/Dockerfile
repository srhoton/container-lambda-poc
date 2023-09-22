FROM public.ecr.aws/lambda/ruby:3.2

# Install the runtime interface client for Ruby
#RUN gem install aws_lambda_ric

# Add the runtime interface client to the PATH
#ENV PATH="/usr/local/bundle/bin:${PATH}"

# Create a directory for the Lambda function
#ENV LAMBDA_TASK_ROOT=/var/task
#RUN mkdir -p ${LAMBDA_TASK_ROOT}
#WORKDIR ${LAMBDA_TASK_ROOT}

# Copy function code
COPY lambda_function.rb ${LAMBDA_TASK_ROOT}/

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ${LAMBDA_TASK_ROOT}/

# Install Bundler and the specified gems
RUN gem install bundler:2.4.6 && bundle  install


# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "lambda_function.LambdaFunction::Handler.process" ]


