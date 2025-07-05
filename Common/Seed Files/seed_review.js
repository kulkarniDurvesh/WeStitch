// MongoDB seed script for Review Service
// Run this in MongoDB shell, Compass, or programmatically via Mongoose

db.product_reviews.insertMany([
    {
      product_id: 101,
      user_id: 1,
      rating: 5,
      comment: "Beautifully made! Exceeded expectations.",
      images: [],
      created_at: new Date(),
      updated_at: new Date(),
      helpful_votes: 3,
      flagged: false
    },
    {
      product_id: 102,
      user_id: 2,
      rating: 4,
      comment: "Loved the color and details. Delivery could be faster.",
      images: ["url-to-review-image-1.jpg"],
      created_at: new Date(),
      updated_at: new Date(),
      helpful_votes: 1,
      flagged: false
    }
  ]);
  
  db.review_replies.insertMany([
    {
      review_id: ObjectId("64fa1d6e0c2fdcf37fc3f9a2"),
      user_id: 3,
      reply: "Thanks for your feedback!",
      created_at: new Date()
    }
  ]);
  
  db.review_images.insertMany([
    {
      review_id: ObjectId("64fa1d6e0c2fdcf37fc3f9a3"),
      image_url: "https://example.com/reviews/img1.jpg",
      uploaded_at: new Date()
    }
  ]);
  
  db.review_votes.insertMany([
    {
      review_id: ObjectId("64fa1d6e0c2fdcf37fc3f9a2"),
      user_id: 4,
      vote_type: "upvote",
      voted_at: new Date()
    }
  ]);
  
  db.review_flags.insertMany([
    {
      review_id: ObjectId("64fa1d6e0c2fdcf37fc3f9a3"),
      user_id: 5,
      reason: "Inappropriate language",
      flagged_at: new Date(),
      status: "pending"
    }
  ]);
  