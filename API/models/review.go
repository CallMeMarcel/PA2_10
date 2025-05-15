package models

import (
	"time"

	"gorm.io/gorm"
)

type Review struct {
	gorm.Model
	ProductID uint      `json:"productId"`
	UserID    uint      `json:"userId"`
	Username  string    `json:"username"`
	Rating    float32   `json:"rating" gorm:"type:decimal(2,1)"`
	Comment   string    `json:"comment" gorm:"type:text"`
	CreatedAt time.Time `json:"createdAt"`
}