# In The Hood - Blueprint

## Overview

This document outlines the style, design, and features of the "In The Hood" Flutter application.

## Style and Design

### Theme

*   **Color Scheme:** The app uses a modern and stylish theme with a primary color of deep purple.
*   **Typography:** The app uses the "Lato" font from Google Fonts for a clean and readable look.
*   **Logo:** The app has a logo that is displayed on the login and home screens.
*   **UI Components:** The app uses modern UI components, such as cards with shadows, gradients, and custom button styles.

### Layout

*   **Login Screen:** The login screen has a background color, a card with a shadow for the login form, and icons in the text fields.
*   **Home Screen:** The home screen has a search bar, a filter option, and a bottom navigation bar.
*   **Listing Cards:** The listing cards have a better layout with the user's avatar and name, and a bookmark icon.
*   **Listing Details Screen:** The listing details screen has a larger image, a "Contact" button, and a "More from this seller" section.
*   **Wallet Screen:** The wallet screen has a card with a gradient background to show the points balance, and a list of recent transactions.
*   **Redeem Points Screen:** A new screen for users to redeem their loyalty points for rewards. The screen now displays a list of available rewards with their point values.

### Imagery Direction

| App Section | Image Type | Lighting Style |
| --- | --- | --- |
| Onboarding | Portland skyline at sunset | Soft magenta → cyan gradient overlay |
| Home / Map Feed | Aerial shot of neighborhoods (Alberta, Sellwood, Downtown) | Neutral, clean daylight glow |
| Auction Feed | Downtown lights / street markets | Night scene, deep cyan glow edges |
| Auction Room | Storefronts or local shops | Focused lighting, blurred edges |
| Community Love Tab | Sunrise over Mount Tabor or St. Johns Bridge | Warm golden-pink overlay |

### Animated Background Behavior

*   **Screen transitions:** Each screen change triggers a smooth fade and glow shift over 1.2s.
*   **Ambient motion:** Background gently zooms or pans (Ken Burns effect) to add depth.
*   **Atmosphere:** Subtle particles or light bokeh drift across the UI.
*   **Color sync:** Timer and map glow colors stay in harmony with the active background hues.

### Image Sourcing Plan

*   **Sources:** Use open-license imagery from Unsplash or Pexels featuring Portland skylines, neighborhoods, and landmarks.
*   **Brand overlay:** Apply custom neon filters to align images with the app’s glow-forward aesthetic.
*   **Optimization:** Export assets at 1920×1080 and ~200KB per image to ensure fast load times.

### Sunset Visual Theme Integration

#### Color Palette

| Element | Gradient / Color |
| --- | --- |
| Background | Golden Amber → Magenta Rose → Soft Violet |
| Button Glows | Warm Neon Orange → Pink Pulse |
| Text Highlights | White with soft orange reflection |
| Map Pins (Community Tab) | Gold, Green, Blue, Pink (warmer shades) |
| Timers / Counters | Soft gold flicker (mimics sun glint) |

#### Visual Plan by Screen

| Screen | Visual Direction |
| --- | --- |
| Live Auction Feed | Portland skyline glowing with sunset reflections, cyan-magenta gradients fading into amber tones, warm-lit auction cards, and gold countdown timers with sunlit shimmer. |
| Auction Room | Street-level Portland photo with sunlit storefronts, blurred background with subtle light rays, softly glowing bid numbers, and a warm orange ripple on the “Place Bid” button. |
| Community Love Tab | Mount Tabor or St. Johns Bridge at sunset with warm pink-gold hues through the map overlay, softly pulsing pins like lanterns, and “Volunteer”/“Donate” buttons with a breathing golden glow. |

#### Transition Guidance

*   **Global motion:** Every screen change fades smoothly with a gold-to-pink gradient wave to evoke the sun moving across the app.
*   **Auction Feed → Auction Room:** Dusk-to-evening transition.
*   **Auction Room → Community Love:** Sunset-to-twilight transition.

### Sunset Edition (Still Cinematic Theme)

#### Design Summary

| Screen | Description | Background Scene |
| --- | --- | --- |
| Auction Feed | Glowing city skyline with warm amber and magenta haze; cards pop against the light. | Portland skyline at sunset (skyline + bridges). |
| Auction Room | Close-up downtown shot with golden reflections in windows and a soft vignette. | Downtown storefronts with a rich pink sky gradient. |
| Community Love Tab | Wide horizon shot of Mount Tabor or St. Johns Bridge with golden sunlight fading to magenta. | Soft, calm, community-centered tone. |

#### Color and Light

*   **Base layer:** Matte black for depth.
*   **Gradient overlay:** #FFB347 → #FF5F6D → #6A1B9A.
*   **Highlights:** Warm golds, glowing pinks, deep purple shadows.
*   **Text:** White with a soft amber reflection for readability.
*   **Accents:** Pins, buttons, and glows stay warm (gold, rose, peach).

#### UI Elements Integration

*   **Auction countdowns:** Subtle golden flicker (static glow, no pulse).
*   **Buttons:** Neon gold → rose gradient with a static glow outline.
*   **Map pins:** Warm glow gradient (no animation).
*   **HoodBot icon:** Subtle backlight glow only (no movement).

#### Why This Works

*   **Authentic:** Feels like a real local experience.
*   **Elegant:** Sunset palette softens neon into premium warmth.
*   **Emotional:** Communicates hope, connection, and community strength.
*   **On brand:** Keeps the glow aesthetic while feeling human and homey.

## Features

### Implemented

*   User authentication (sign in, sign out).
*   Create, view, and search for listings.
*   Admin screen to manage the app.
*   Wallet screen to view points balance and redeem points.
*   Redeem points screen with a list of rewards and redemption logic.

### Current Task

*   The redeem points feature is complete.
