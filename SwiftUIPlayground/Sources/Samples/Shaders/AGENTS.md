# Shader V2 Card Effects

## Design Language
- V2 card effects are cyberpunk neon glass: electric cyan, neon magenta, blue-violet, and dark ink.
- The style is clean, graphic, and designed. It should feel like a polished shader language, not a realistic texture simulation.
- Prefer gradients, inner glows, translucent glass layers, satin shimmer, and controlled edge energy.
- Use procedural detail sparingly. Detail should be fine and atmospheric, not gritty or noisy.

## Card Surface
- Cards use the dark ink base color `#1E201E`.
- Card effects are evaluated over centered character content, currently an emoji.
- Effects should usually sit over the character content so they feel integrated with the card surface.
- Preserve readability of the character: effects may tint or soften it, but should not fully wash it out.

## Frost Effect Direction
- Frost in V2 is a stylized neon-glass inner glow, not literal ice.
- Frost should originate from all card edges and travel inward, then fade before overpowering the center.
- The center should remain mostly clear, with no center marker or heavy haze.
- The current successful direction is a transparent cyan/blue-violet edge aura with subtle magenta warmth and soft inward falloff.
- Avoid X shapes, large blobs, hard diagonal bands, speckles, scratches, grunge, dirt, stains, splats, and realistic game-style frost.
