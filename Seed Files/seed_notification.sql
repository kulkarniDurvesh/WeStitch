// MongoDB seed script for Notification Service
// Run this in MongoDB shell or via a seeding tool like MongoDB Compass or Mongoose

db.notifications.insertMany([
  {
    user_id: 1,
    type: "order_confirmation",
    content: "Your order #1234 has been confirmed.",
    status: "unread",
    created_at: new Date(),
  },
  {
    user_id: 1,
    type: "shipping_update",
    content: "Your order #1234 has been shipped.",
    status: "unread",
    created_at: new Date(),
  }
]);

db.email_templates.insertMany([
  {
    name: "order_confirmation",
    subject: "Your order has been confirmed!",
    body: "Hi {{name}}, your order {{order_id}} is confirmed. Thank you!",
    created_at: new Date(),
  },
  {
    name: "shipping_notification",
    subject: "Order Shipped!",
    body: "Hi {{name}}, your order {{order_id}} has shipped and is on its way.",
    created_at: new Date(),
  }
]);

db.sms_templates.insertMany([
  {
    name: "otp_verification",
    message: "Your OTP code is {{otp}}",
    created_at: new Date(),
  },
  {
    name: "order_shipped",
    message: "Hi {{name}}, your order #{{order_id}} has been shipped.",
    created_at: new Date(),
  }
]);

db.notification_logs.insertOne({
  notification_id: ObjectId("64f9a5b2b5a644a5d1fbd1e3"),
  sent_at: new Date(),
  delivery_status: "sent",
  channel: "email"
});

db.user_notification_preferences.insertOne({
  user_id: 1,
  preferences: {
    email: true,
    sms: false,
    push: true
  },
  updated_at: new Date()
});
