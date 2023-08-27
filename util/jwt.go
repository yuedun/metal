package util

import (
	"time"

	"github.com/golang-jwt/jwt/v5"
)

type AuthClaim struct {
	ID       uint   `json:"id"`
	Username string `json:"username"`
	Email    string `json:"email"`
	jwt.RegisteredClaims
}

// @secretKey: JWT 加解密密钥
// @seconds: 过期时间，单位秒
// @payload: 数据载体
func GetJwtToken(secretKey string, seconds int64, payload AuthClaim) (string, error) {
	claims := AuthClaim{
		Username: payload.Username,
		Email:    payload.Email,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(time.Duration(seconds) * time.Second)), // 过期时间24小时
			IssuedAt:  jwt.NewNumericDate(time.Now()),                                           // 签发时间
			NotBefore: jwt.NewNumericDate(time.Now()),                                           // 生效时间
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString([]byte(secretKey))
}

func ParseToken(token, secret string) (*AuthClaim, error) {
	tokenClaims, err := jwt.ParseWithClaims(token, &AuthClaim{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(secret), nil
	})
	if err != nil {
		return nil, err
	}

	if tokenClaims != nil {
		if claims, ok := tokenClaims.Claims.(*AuthClaim); ok && tokenClaims.Valid {
			return claims, nil
		}
	}

	return nil, err
}
