import { postalCodePatterns } from "./countryData";

export function validatePostalCode(postalCode: string, country: string) {
  const pattern = postalCodePatterns[country] || postalCodePatterns.default;
  return pattern.test(postalCode.trim());
}

export function validatePhoneNumber(phone: string) {
  return /^\+\d{8,15}$/.test(phone.trim());
}

export function isPasswordSafe(pwd: string) {
  const minLength = 8;
  const hasLetter = /[a-zA-Z]/.test(pwd);
  const hasNumber = /\d/.test(pwd);
  const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(pwd);
  return pwd.length >= minLength && hasLetter && hasNumber && hasSpecialChar;
}
