package migrations

import (
	"gorm.io/gorm"
)

func AddImageUrlToUsers(db *gorm.DB) error {
	return db.Exec("ALTER TABLE users ADD COLUMN image_url VARCHAR(255)").Error
}