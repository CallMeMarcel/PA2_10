package controllers

import (
	"api/models"
	"strconv"
	"time"

	"github.com/gofiber/fiber/v2"
	"gorm.io/gorm"
)

type ReviewController struct {
	db *gorm.DB
}

func NewReviewController(db *gorm.DB) *ReviewController {
	return &ReviewController{db: db}
}

type ReviewResponse struct {
	ID        uint      `json:"id"`
	ProductID uint      `json:"productId"`
	UserID    uint      `json:"userId"`
	Username  string    `json:"username"`
	Rating    float32   `json:"rating"`
	Comment   string    `json:"comment"`
	CreatedAt time.Time `json:"createdAt"`
}

// @Summary Submit a review
// @Description Submit a product review
// @Tags Reviews
// @Accept json
// @Produce json
// @Security ApiKeyAuth
// @Param input body models.Review true "Review data"
// @Success 201 {object} ReviewResponse
// @Router /api/reviews [post]
func (rc *ReviewController) SubmitReview(c *fiber.Ctx) error {
	// Get user from JWT
	user := c.Locals("user").(*models.User)
	if user == nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{
			"message": "Unauthorized",
		})
	}

	var input struct {
		ProductID uint    `json:"productId"`
		Rating    float32 `json:"rating"`
		Comment   string  `json:"comment"`
	}

	if err := c.BodyParser(&input); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid request body",
		})
	}

	// Validate input
	if input.Rating < 0 || input.Rating > 5 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Rating must be between 0 and 5",
		})
	}

	review := models.Review{
		ProductID: input.ProductID,
		UserID:    user.Id,
		Username:  user.Username,
		Rating:    input.Rating,
		Comment:   input.Comment,
		CreatedAt: time.Now(),
	}

	if err := rc.db.Create(&review).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Failed to create review",
		})
	}

	response := ReviewResponse{
		ID:        review.ID,
		ProductID: review.ProductID,
		UserID:    review.UserID,
		Username:  review.Username,
		Rating:    review.Rating,
		Comment:   review.Comment,
		CreatedAt: review.CreatedAt,
	}

	return c.Status(fiber.StatusCreated).JSON(response)
}

// @Summary Get product reviews
// @Description Get all reviews for a product
// @Tags Reviews
// @Accept json
// @Produce json
// @Param productId query int true "Product ID"
// @Success 200 {object} []ReviewResponse
// @Router /api/reviews [get]
func (rc *ReviewController) GetReviews(c *fiber.Ctx) error {
	productId, err := strconv.Atoi(c.Query("productId"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"message": "Invalid product ID",
		})
	}

	var reviews []models.Review
	if err := rc.db.Where("product_id = ?", productId).
		Order("created_at desc").
		Find(&reviews).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"message": "Failed to fetch reviews",
		})
	}

	// Calculate average rating
	var totalRating float32 = 0
	for _, review := range reviews {
		totalRating += review.Rating
	}
	averageRating := float32(0)
	if len(reviews) > 0 {
		averageRating = totalRating / float32(len(reviews))
	}

	var response []ReviewResponse
	for _, review := range reviews {
		response = append(response, ReviewResponse{
			ID:        review.ID,
			ProductID: review.ProductID,
			UserID:    review.UserID,
			Username:  review.Username,
			Rating:    review.Rating,
			Comment:   review.Comment,
			CreatedAt: review.CreatedAt,
		})
	}

	return c.JSON(fiber.Map{
		"reviews":       response,
		"averageRating": averageRating,
	})
}