FROM rabbitmq:4.1-management

# Copy the plugins into the RabbitMQ plugins directory
COPY plugins/rabbitmq_delayed_message_exchange-4.1.0.ez $RABBITMQ_HOME/plugins/
COPY plugins/rabbitmq_message_deduplication-0.7.1.ez $RABBITMQ_HOME/plugins/
COPY plugins/elixir-1.18.3.ez $RABBITMQ_HOME/plugins/

# Change ownership to rabbitmq
RUN chown rabbitmq:rabbitmq $RABBITMQ_HOME/plugins/rabbitmq_delayed_message_exchange-4.1.0.ez && \
    chown rabbitmq:rabbitmq $RABBITMQ_HOME/plugins/rabbitmq_message_deduplication-0.7.1.ez && \
    chown rabbitmq:rabbitmq $RABBITMQ_HOME/plugins/elixir-1.18.3.ez

# Enable the plugins
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange \
    rabbitmq_message_deduplication \
    rabbitmq_shovel \
    rabbitmq_shovel_management

EXPOSE 5672 15672