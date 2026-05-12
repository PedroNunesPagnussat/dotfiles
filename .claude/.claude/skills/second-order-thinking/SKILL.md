---
name: second-order-thinking
description: Apply rigorous second-order thinking to a hard decision, plan, or proposal. Use whenever the user is weighing a non-trivial choice ("should I quit my job", "we're considering migrating to microservices", "thinking about moving cities") and wants to surface downstream consequences, hidden costs, what gets foreclosed, and failure modes before committing. Trigger phrases include "second-order effects of X", "what am I missing about X", "think through the consequences of X", "what could go wrong with X", "help me decide whether to X", or any variant where the user wants structured analysis of a decision rather than a quick opinion. Use this even when the user is just describing a decision they're wrestling with, since the skill exists to force the structured analysis they probably need.
---

# Second-Order Thinking

Force structured analysis of a hard decision by surfacing what comes after the obvious first effect.

This skill exists because most decision-making stops at first-order effects. "If we move closer to my partner's family, the kids will see their grandparents more" is first-order. The interesting questions are second-order: what happens to your own friendships when you're three hours from your closest friends, what does the longer commute do to your evening energy over five years, what does living near in-laws do to the dynamics in your marriage, what becomes harder to reverse once the kids put down roots in the new school. That's where the real stakes are, and it's the part most people skip.

The user is using this skill on a decision that matters. Don't be shallow, don't pad, don't hedge. Push them.

## Workflow

The default mode is **wide**: cast a broad net across the categories below, surface effects the user probably hasn't considered. The user will pick threads they want to pull, and subsequent turns will go **deep** on those specific threads (third-order, fourth-order, gaming out specific scenarios).

Don't go deep on the first pass. The point of the wide pass is to give the user a map of what's worth thinking harder about.

### Step 1: Restate the decision

One sentence at the top, in your own words. This catches misreadings before they cascade. If the decision as stated is ambiguous (e.g., "should I quit my job", but quit to do what?), name the ambiguity and either ask or pick the most likely interpretation and flag it.

### Step 2: First-order effects (brief)

Two or three bullets, no more. Just the obvious immediate consequences. The point is to acknowledge them and clear them out of the way, not analyze them. If you find yourself spending time here, you're stalling.

### Step 3: Second-order effects (the meat)

Organize by category. Use as many categories as the decision warrants, group or skip when they don't apply. Within each category, push for specifics, not abstractions. "You'll lose flexibility" is weak. "Once the kids are enrolled in this school, switching mid-year costs them their friend group and you a 40-minute longer commute, so you're effectively locked in for at least 18 months" is strong.

**What it costs**
Beyond money. Time, attention, identity, optionality, social capital, energy, status, momentum, peace of mind. The non-obvious costs that don't show up on a spreadsheet but determine whether the decision was actually worth it.

**What it forecloses**
Paths that close once you commit. Some decisions are reversible, some aren't. Some are reversible in theory but not in practice (rolling back a database migration is technically possible but in practice nobody ever does it once production has run on the new schema for a month). Name what gets locked in.

**What it enables**
Compounding effects, new options that open up, second-order benefits that aren't visible from the starting position. Push for specifics here too, vague upside is as useless as vague downside. Useful angles:
- What new options open up that weren't accessible before? (a working second language opens up not just travel but specific job markets, friendships, and content you couldn't access before)
- What compounds over time? Skills, network, reputation, optionality, leverage
- What identity shifts become possible? (going from "person who attends conferences" to "person who speaks at conferences" changes who reaches out to you)
- What does the user learn or notice that they couldn't from the starting position?

This section deserves the same weight as the cost analysis. The skill is biased toward surfacing what's hidden, and upside is often as hidden as downside.

**Who or what loses**
Every decision has people or systems that lose, even if the loss is small or diffuse. Naming them makes the tradeoff concrete instead of abstract. Sometimes the answer is "no one significant", say so when it's true. But check first.

### Step 4: Failure modes

This is a pre-mortem: imagine the decision has been made and it failed badly. Now work backwards. What happened? What signals were ignored? What assumption turned out to be wrong?

Costs are expected, failure modes are when things go sideways. Useful prompts:
- What does the worst plausible version of this decision look like one year out? Three years out?
- What would have to be true for this to fail badly?
- What's the early warning sign that things are going wrong, and would the user notice it in time to course-correct?
- What's the user underestimating? What are they overestimating?

Pre-mortem is from Gary Klein, the idea is that imagining failure concretely (rather than abstractly worrying about risk) is the most reliable way to surface failure modes that prevention is actually possible for. Use it that way: concrete scenarios, not vague risks.

### Step 5: Counterfactual and opportunity cost

Compared to what? Most decision analysis fails because it analyzes the proposed action in isolation. The right question is always "this versus what alternative?"

Three angles worth covering:

- **Doing nothing**: what happens if the user just doesn't decide, or maintains the status quo? Status quo has its own second-order effects, and people often forget that not deciding is itself a decision. Sometimes the status quo is quietly degrading and inaction is the real risk
- **The opposite**: what happens if the user does the opposite of what they're proposing? Sometimes this reveals that the proposed action is obviously right, sometimes it reveals that the alternative was never seriously considered
- **The best alternative use of the same resources**: if the user is committing time/money/attention to this, what else could those resources do? This is the explicit opportunity cost question, and it's the one most people skip

If the user has already named alternatives, evaluate against those instead of generating hypotheticals.

### Step 6: Calibration questions for going deeper

End with pointed questions about which threads are worth pulling. Not generic ("what are your goals?"), but pointed at specific effects you surfaced. Examples:

- "You said the income drop is fine for 12 months, but the foreclosure on going back to a senior role at a top-tier company compounds the longer you're out. How long do you actually expect to be out?"
- "The microservices migration enables independent team velocity, but you have 12 engineers. At what team size does the operational overhead start to pay back?"
- "If you move cities, the loss of weekly in-person time with your aging parents is the failure mode. Have you thought about what frequency of visits would make this acceptable to you?"

The user will pick which threads to pull. Subsequent turns go deep on those, gaming out third-order effects, specific scenarios, what-ifs.

## Tone and format

- Write in plain language. The user is making a real decision, don't lecture, don't pad
- Use bullets, tables, scenarios, whatever fits. Structure should serve the analysis
- No em-dashes, use commas, parentheses, colons, or two sentences instead
- Skip preambles like "This is a tough decision!" or "Great question"
- When the decision is obviously good or obviously bad, say so. Don't manufacture balance for the sake of looking neutral
- Be willing to push back on the framing. If the user's stated decision is the wrong question, say so. ("You're asking which diet to follow, but the real question seems to be why the last three didn't stick")

## Things to avoid

- **Symmetric hedging.** "On one hand X, on the other hand Y" without weight. If the evidence leans one way, say so. The user came for analysis, not balanced both-sidesing
- **Generic risks.** "There's uncertainty" applies to everything. Specific failure modes only
- **Going deep on the first pass.** Wide first, deep on follow-ups. Don't try to game out every scenario in the initial response
- **Being agreeable.** If the user's plan has a flaw, name it. Softening the critique to stay friendly is the failure mode of this skill
- **Pretending to know things you don't.** If the analysis depends on numbers or facts you don't have, ask for them or flag the dependency