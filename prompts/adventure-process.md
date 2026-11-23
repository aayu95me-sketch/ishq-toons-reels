# Adventure reel process (from NEW-PROJECT-STARTER-KIT, set up 23 Nov 2026)

Goal line (top of every council prompt): "Make a 15 s realistic POV adventure reel that an Indian 15-35 year old stops on in second 1, watches to the end, rewatches, and shares/tags a friend."

## Why transitions looked fake (found 23 Nov)
Omni 1.2 Flash builds a 15 s clip from pieces: 0-5.3 s, 5.3-9.0 s, 9.0-13.2 s, 13.2-15 s.
At each seam the light and position jump (a jump cut inside one shot). Prompts cannot remove it.
Fix: plan a NEW CAMERA ANGLE for each piece, so every seam becomes a real, intentional cut
(like a GoPro/drone travel edit). Never ask for one continuous take on Omni again.
Shot slots: S1 0-5 s (hook), S2 5-9 s, S3 9-13 s, S4 13-15 s (payoff).
Check: scene-score scan (scripts/seams.sh) must show cuts only at the slot times.

## Steps for every reel
1. Idea score (7 checks, 0-2 each): first-second hook, audience need/feeling, curiosity, visual proof, fast payoff, share/save reason, rewatch pacing. Make only 11/14+.
2. Viewer-moment card: who, second-1 feeling, one ask + exact words, why, swipe risk.
3. Shot sheet: 4 shots on the slot times above + hook text + end ask.
4. COUNCIL (Gemini + ChatGPT in owner's Chrome, blind, scores /10 + top fix). Pass 7+/10 from both, else fix and rescore once.
5. Generate in Flow (60 credits / 15 s). One render; re-render only if a gate fails.
6. Gate 3 visuals: contact sheet, seam scan, no text/logos/faces/AI glitches. 7+.
7. Edit: hook text 0-1.6 s (big, held 1.5 s), end ask last 2 s, loop check.
8. Gate 4: council watches frames of the final + Claude: stop score 8+, viewer card 8+.
9. Owner sees it. Owner's typed OK only. Then scheduled post, AI label ticked.
Lock this process 14 days; one council round per reel draft, no more.
